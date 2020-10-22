let gridContainer = document.getElementsByClassName("grid-container")[0];
let gridItemCollection;
let gridNumber = 10;
let reset = document.getElementById("refresh");
reset.addEventListener("click", resetGrid);

function addGridElements() {
  for (let i = 0; i < gridNumber ** 2; i++) {
    let gridItem = document.createElement("div");
    gridItem.classList.add("grid-item");
    gridContainer.appendChild(gridItem);
  }
}

function sizeGridElement(item) {
  let gridItemSize = gridContainer.clientWidth / gridNumber;
  item.style.width = gridItemSize + "px";
  item.style.height = gridItemSize + "px";
}

function darkenPixel(item) {
  let opacity = 0.1;
  item.addEventListener("mouseenter", (event) => {
    item.style.opacity = opacity;
    opacity += 0.2;
  });
}

function resetGrid() {
  gridItemCollection = [...document.querySelectorAll(".grid-item")];
  gridItemCollection.forEach((e) => {
    e.remove();
  });
  gridNumber = prompt(
    "Please enter a grid pixel size: Keep it under 50 as I can't be bothered to limit your choice."
  );
  addGridElements();
  setUpGrid();
}

function setUpGrid() {
  addGridElements();
  gridItemCollection = [...document.querySelectorAll(".grid-item")];
  gridItemCollection.forEach(sizeGridElement);
  gridItemCollection.forEach(darkenPixel);
}

setUpGrid();
