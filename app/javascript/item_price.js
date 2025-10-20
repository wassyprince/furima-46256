window.addEventListener('turbo:load', () => {
  console.log("OK");
});

const price = () => { 
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);

    if (isNaN(price) || price < 300 || price > 9999999) {
      addTaxDom.innerHTML = "-";
      profitDom.innerHTML = "-";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);