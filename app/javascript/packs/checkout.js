document.addEventListener("DOMContentLoaded", function () {
  // Set up Stripe with your publishable key
  var stripe = Stripe("pk_test_51QVNU9P45Oh4FvguplxYA0BwoBb6ri2ORK5EljkFDC1lfFsxaM7Ebp7XPn09gmp6BahjRbMD8XHdWJ8gGtCpvviB00mCx7Z72d");  // Use the publishable key from credentials
  var elements = stripe.elements();


  // Customize the style for the Stripe Elements
  var style = {
    base: {
      color: "#32325d",
      fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
      fontSmoothing: "antialiased",
      fontSize: "16px",
      "::placeholder": {
        color: "#aab7c4"
      }
    },
    invalid: {
      color: "#fa755a",
      iconColor: "#fa755a"
    }
  };

  // Create the card element
  var card = elements.create("card", { style: style });
  card.mount("#card-element");  // This targets the HTML element where the card input should be displayed

  // Get the form element
  var form = document.getElementById("payment-form");

  // Handle form submission
  form.addEventListener("submit", function (event) {
    event.preventDefault();  // Prevent the default form submission

    // Create a token for the card details
    stripe.createToken(card).then(function (result) {
      if (result.error) {
        // Display any error that occurs during the token creation
        document.getElementById("card-errors").textContent = result.error.message;
      } else {
        // Insert the Stripe token into the form and submit it
        var tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "stripeToken");
        tokenInput.setAttribute("value", result.token.id);
        form.appendChild(tokenInput);

        // Submit the form
        form.submit();
      }
    });
  });
});
