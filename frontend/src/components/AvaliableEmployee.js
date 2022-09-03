import React from "react";

export function AvaliableEmployee({ onSubmit, employees }) {
  return (
    <p>
      Employees to purchase:{" "}
      <ul>
        {employees.map((em) => (
          <li key={em.name}>
            <p>Name: {em.name}</p>
            <p>Price: {em.price}</p>
            <form
              onSubmit={(event) => {
                console.log("cze");
                // This function just calls the transferTokens callback with the
                // form's data.
                event.preventDefault();

                const formData = new FormData(event.target);
                const id = +formData.get("id");

                if (id) {
                  onSubmit(id);
                }
              }}
            >
              <input type="hidden" defaultValue={1} name="id" />
              <button type="submit">Buy</button>
            </form>
          </li>
        ))}
      </ul>
    </p>
  );
}
