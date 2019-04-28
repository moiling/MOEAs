function f = CrowdingDistance(x, F, M, V)
    %% Crowding distance
    current_index = 0;

    for front = 1 : (length(F) - 1)

        y = [];
        previous_index = current_index + 1;

        for i = 1 : length(F(front).f)
            y(i, :) = x(current_index + i,:);
        end
        current_index = current_index + i;

        % Sort each individual based on the objective
        for i = 1 : M

            [~, index_of_objectives] = sort(y(:, V + i));
            sorted_based_on_objective = [];

            for j = 1 : length(index_of_objectives)
                sorted_based_on_objective(j, :) = y(index_of_objectives(j), :);
            end

            f_max = sorted_based_on_objective(length(index_of_objectives), V + i);
            f_min = sorted_based_on_objective(1, V + i);

            % The distance information saved in last position of data
            % 1 and End => Inf
            y(index_of_objectives(length(index_of_objectives)), M + V + 1 + i) = Inf;
            y(index_of_objectives(1), M + V + 1 + i) = Inf;

            for j = 2 : length(index_of_objectives) - 1
                next_obj = sorted_based_on_objective(j + 1, V + i);
                previous_obj = sorted_based_on_objective(j - 1, V + i);

                if (f_max - f_min == 0)
                    y(index_of_objectives(j), M + V + 1 + i) = Inf;
                else
                    y(index_of_objectives(j), M + V + 1 + i) = (next_obj - previous_obj) / (f_max - f_min);
                end
            end
        end

        distance = [];
        distance(:, 1) = zeros(length(F(front).f), 1);
        for i = 1 : M
            distance(:, 1) = distance(:, 1) + y(:, M + V + 1 + i);
        end

        y(:, M + V + 2) = distance;
        y = y(:, 1 : M + V + 2);
        z(previous_index: current_index, :) = y;
    end

    f = z();