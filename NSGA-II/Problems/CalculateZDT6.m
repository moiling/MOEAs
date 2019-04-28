function [f] = CalculateZDT6(x)
% M: number_of_objectives
% V: number_of_decision_variables
% min_range: min_range_of_decesion_variable (vector)
% max_range: max_range_of_decesion_variable (vector)

		V = 10;

		f = [];
		f(1) = 1 - exp(-4 * x(1)) * (sin(6 * pi * x(1)))^6;

		sum = 0;
		for i = 2 : V
		    sum = sum + x(i) / (V - 1);
		end

		g_x = 1 + 9 * (sum)^(0.25);

		f(2) = g_x * (1 - ((f(1)) / (g_x))^2);
