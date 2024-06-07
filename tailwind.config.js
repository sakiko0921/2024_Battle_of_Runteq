const plugin = require("tailwindcss");

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: ["nord", "pastel", "cupcake"],
    },
}
