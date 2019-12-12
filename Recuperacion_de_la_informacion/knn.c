#include<stdio.h>
#include<math.h>

double distance(double x1, double y1, double x2, double y2) {
	double z1 = pow(x2 - x1, 2);
	double z2 = pow(y2 - y1, 2);
	
	return sqrt(z1 + z2);
}


int main(int argc, char ** argv) {
	double speed[20] = {2.5, 3.75, 2.25, 3.25, 2.75, 4.5, 3.5, 3, 4, 4.25, 2, 5, 8.25, 5.75, 4.75, 5.5, 5.25, 7, 7.5, 7.25};
	double agility[20] = {6, 8, 5.5, 8.25, 7.5, 5, 5.25, 7.5, 5, 5.25, 3.25, 4, 3.75, 2, 2.5, 8.5, 8.75, 6.25, 6.75, 9.5, 4.25, 8, 5.75};

	double distances[20];
	for (int i = 0; i < len(speed); i++) {
		distances[i] = distance(speed[i], agility[i], 6.75, 3.0);
	}

	printf("%d", distance(3, 2, 7, 8));

	return 0;
}