document.addEventListener("DOMContentLoaded", () => {
  const menus = document.querySelectorAll("details.anchor-menu");

  menus.forEach((menu) => {
    const trigger = menu.querySelector("summary");

    menu.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => menu.removeAttribute("open"));
    });

    menu.addEventListener("keydown", (event) => {
      if (event.key !== "Escape") return;

      menu.removeAttribute("open");
      trigger?.focus();
    });
  });

  document.addEventListener("click", (event) => {
    menus.forEach((menu) => {
      if (menu.open && !menu.contains(event.target)) {
        menu.removeAttribute("open");
      }
    });
  });
});
