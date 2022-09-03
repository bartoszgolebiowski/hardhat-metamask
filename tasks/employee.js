const fs = require("fs");

const employee = {
  id: 10,
  name: "Bob",
  salary: 100,
};

const employee2 = {
  id: 20,
  name: "John",
  salary: 200,
};

task("employee", "Create two mock employees").setAction(
  async ({}, { ethers }) => {
    if (network.name === "hardhat") {
      console.warn(
        "You are running the faucet task with Hardhat network, which" +
          "gets automatically created and destroyed every time. Use the Hardhat" +
          " option '--network localhost'"
      );
    }

    const addressesFile =
      __dirname + "/../frontend/src/contracts/contract-address.json";

    if (!fs.existsSync(addressesFile)) {
      console.error("You need to deploy your contract first");
      return;
    }

    const addressJson = fs.readFileSync(addressesFile);
    const address = JSON.parse(addressJson);

    if ((await ethers.provider.getCode(address.Token)) === "0x") {
      console.error("You need to deploy your contract first");
      return;
    }

    const hardhatToken = await ethers.getContractAt("Token", address.Token);
    const [sender] = await ethers.getSigners();

    await hardhatToken.registerEmployee(
      employee.name,
      employee.salary,
      employee.id
    );
    await hardhatToken.registerEmployee(
      employee2.name,
      employee2.salary,
      employee2.id
    );

    await hardhatToken.purchaseEmployee(employee.id);
    await hardhatToken.purchaseEmployee(employee2.id);

    console.log(await hardhatToken.getEmployees(sender.address));
  }
);
