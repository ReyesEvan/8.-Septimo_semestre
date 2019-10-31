var Clothing = (function(d, p) {

	Clothing.counter = ++Clothing.counter || 1

	var id = Clothing.counter
	var description = d 
	var price = p

	return {
		getID: function() {return id},
		getDescription: function() {return description},
		getPrice: function () { return price},

		displayInformation() {
			console.log('ID: ' + id)
			console.log('Description: ' + d)
			console.log('Price: ' + p)
		}
	}
})

var Shirt = (function(d, p, s, c) {
	var shirt = Clothing(d, p)
	
	const validSizes = ['S', 'L', 'M']
	var size = validSizes.includes(s) ? s : 'Undefined'
	const validColors = ['R', 'G', 'B']
	var color = validColors.includes(c) ? c : 'Undefined'

	shirt.getSize = () => {return size}
	shirt.getColorCode = () => {return color}
	
	shirt.displayInformation = function() {
		console.log('ID: ' + shirt.getID())
		console.log('Description: ' + shirt.getDescription())
		console.log('Price: ' + shirt.getPrice())
		console.log('Size: ' + size)
		console.log('Color: ' + color)
	}
	return shirt
})

var c = Clothing("A", 12)
c.displayInformation()
var d = Clothing("B", 10)
d.displayInformation()

var e = Shirt('E', 120, 'M', 'B')
e.displayInformation()
