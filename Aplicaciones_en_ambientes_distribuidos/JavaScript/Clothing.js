var Clothing = (function(d, p) {

	Clothing.counter = ++Clothing.counter || 1

	const id = Clothing.counter
	const description = d 
	const price = p

	return {
		getID() {
			return id
		},
		getDescription: () => {return description},
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

console.log(`Get id: ${c.getDescription()}`)

var d = Clothing("B", 10)
d.displayInformation()

var e = Shirt('E', 120, 'M', 'B')
e.displayInformation()
