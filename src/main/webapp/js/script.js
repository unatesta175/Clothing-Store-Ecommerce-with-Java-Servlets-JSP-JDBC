



window.addEventListener("scroll", function () {
    var navbar = document.querySelector(".sticky-navbar");
    if (window.scrollY > 50) {  // Adjust 50px threshold as needed
        navbar.classList.add("scrolled");
    } else {
        navbar.classList.remove("scrolled");
    }
});