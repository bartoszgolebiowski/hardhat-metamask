import React from "react";

export function MyEmployees({ employees }) {
  return (
    <p>
      My employees:{" "}
      <ul>
        {employees.map((em) => (
          <li key={em.name}>
            <p>Name: {em.name}</p>
            <p>Price: {em.price}</p>
          </li>
        ))}
      </ul>
    </p>
  );
}
