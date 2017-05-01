require './config/environment'


use Rack::MethodOverride
use ReviewController
use UserController
use RestroomController
run ApplicationController
