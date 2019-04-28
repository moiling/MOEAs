function [M, V, min_range, max_range] = InitialZDT6()
% M: number_of_objectives
% V: number_of_decision_variables
% min_range: min_range_of_decesion_variable (vector)
% max_range: max_range_of_decesion_variable (vector)

		M = 2;
		V = 10;

		for i = 1 : V
		    min_range(i) = 0;
		    max_range(i) = 1;
    end