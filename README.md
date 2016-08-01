Test task: “System for solving mathematical equations”.

The system should contain 2 main components:
	1	Frontend server.
	2 	Backend server

	1 Frontend server requirements

RoR application must provide:
	a) Selection of the type of equation (the default are linear and quadratic)
	b) The form for inputting the parameters of the solution
	c) Sending the parameters of the equation to the backend server using JSON
	d) Displaying the result in the "friendly" format.

Features are welcomed:
	a) Use CSS for web page design (input form, result page, progress bar/spinner)
	b) Use JS / Ajax in forms, selection page, input, output, and validation
	c) Use test frameworks TestUnit / RSpec / Cucumber (one or more)
	d) Validate parameters and handle exceptions (500 backend, entering letters parameters, input of fractional parameters, etc.)


	2 Backend server requirements

The application must be written in Ruby or Sinatra or similar framework, NOT Rails or RailsAPI.
 
The application must:
	a) Provide an API for the parameters for solving equation
	b) Solve the equation
	c) Return the response in JSON format

Features are welcomed:
	a) Use class inheritance to provide single object interface for solving various types of equations.
	b) Use parameter validations and exception handling (insufficient number of parameters, wrong type of equation, wrong type of argument, etc.) and return the error in friendly format.
	c) Use TestUnit / RSpec / Cucumber (one or more)
	d) Using the authentication to backend access
