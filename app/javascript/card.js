const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (
    !document.getElementById("number-form") ||
    !document.getElementById("expiry-form") ||
    !document.getElementById("cvc-form")
  ) return;

  if (form.dataset.payjpInitialized === "1") return;
  form.dataset.payjpInitialized = "1";

  const publicKey = window.gon?.public_key;
  if (!publicKey) return;

  window.__payjp ||= Payjp(publicKey);
  const payjp = window.__payjp;

  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener(
    "submit",
    async (e) => {
      e.preventDefault();

      form.querySelector('input[name="order_address[token]"]')?.remove();

      const response = await payjp.createToken(numberElement);

      if (response.error) return;

      const tokenInput = document.createElement("input");
      tokenInput.type = "hidden";
      tokenInput.name = "order_address[token]";
      tokenInput.value = response.id;
      form.appendChild(tokenInput);

      form.submit();
    },
    { once: true }
  );
};

document.addEventListener("turbo:load", pay);