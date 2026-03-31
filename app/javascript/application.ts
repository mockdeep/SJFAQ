import "@hotwired/turbo-rails";
import "@rails/activestorage";
import {session} from "@hotwired/turbo";
import "@rails/actioncable";
import "trix";
import "@rails/actiontext";

import "./controllers/index";

session.drive = false;
