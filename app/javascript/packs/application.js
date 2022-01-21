// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You"re encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it"ll be compiled.

require("jquery")
import "bootstrap"
require("../lib/owl.carousel.min")
require("../lib/jquery.sticky")
require("../lib/jquery.easing.1.3.min")
require("./main")
require("../lib/bxslider.min")
require("./script.slider")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/css/all.css";

Rails.start()
Turbolinks.start()
ActiveStorage.start()