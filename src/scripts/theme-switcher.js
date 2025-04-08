document.addEventListener("DOMContentLoaded", () => {
  // Check for saved theme preference or use preferred color scheme
  const currentTheme =
    localStorage.getItem("theme") || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light")

  // Apply the theme
  document.documentElement.setAttribute("data-theme", currentTheme)

  // Update the toggle if dark mode is active
  const toggleSwitch = document.getElementById("theme-switch")
  if (toggleSwitch) {
    toggleSwitch.checked = currentTheme === "dark"
  }

  // Update icon based on theme
  updateThemeIcon(currentTheme)
})

// Function to toggle theme
function toggleTheme(e) {
  const newTheme = e.target.checked ? "dark" : "light"

  // Apply the theme
  document.documentElement.setAttribute("data-theme", newTheme)

  // Save the preference
  localStorage.setItem("theme", newTheme)

  // Update icon
  updateThemeIcon(newTheme)
}

// Function to update the theme icon
function updateThemeIcon(theme) {
  const themeIcon = document.getElementById("theme-icon")
  if (themeIcon) {
    themeIcon.innerHTML = theme === "dark" ? "🌙" : "☀️"
  }
}
