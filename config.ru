require './config/environment'

use Rack::MethodOverride
use SessionController
use ReviewController
use UserController
use RestroomController
run ApplicationController
