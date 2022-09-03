import React from "react";

export function CreateEmployee({ onSubmit }) {
  return (
    <div>
      <h4>Create employee</h4>
      <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();

          const formData = new FormData(event.target);
          const id = +formData.get("id");
          const name = formData.get("name");
          const price = +formData.get("price");

          if (name && price) {
            onSubmit(name, price, id);
          }
        }}
      >
        <div className="form-group">
          <label>ID</label>
          <input
            className="form-control"
            name="id"
            type="number"
            required
            min={1}
          />
        </div>
        <div className="form-group">
          <label>Name</label>
          <input className="form-control" name="name" required />
        </div>
        <div className="form-group">
          <label>Price</label>
          <input className="form-control" type="number" name="price" required />
        </div>
        <div className="form-group">
          <input className="btn btn-primary" type="submit" value="Add" />
        </div>
      </form>
    </div>
  );
}
