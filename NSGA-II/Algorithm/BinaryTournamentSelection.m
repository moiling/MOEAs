function f = BinaryTournamentSelection(chromosome, pool_size)

[pop, variables] = size(chromosome);
% The position saved rank and distance
rank_position = variables - 1;
distance_position = variables;

for i = 1 : pool_size
    % Random select 2 different parents
    for j = 1 : 2
        candidate(j) = round(pop * rand(1));
        if candidate(j) == 0
            candidate(j) = 1;
        end
    end

    while candidate(1) == candidate(2)
        candidate(2) = round(pop * rand(1));
        if candidate(2) == 0
            candidate(2) = 1;
        end
    end

    for j = 1 : 2
        c_obj_rank(j) = chromosome(candidate(j), rank_position);
        c_obj_distance(j) = chromosome(candidate(j), distance_position);
    end

    % Choose min rank one, if same rank, choose max distance one
    min_candidate = find(c_obj_rank == min(c_obj_rank));

    if length(min_candidate) ~= 1
        max_candidate = find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);
        end
        f(i, :) = chromosome(candidate(min_candidate(max_candidate)), :);
    else
        f(i, :) = chromosome(candidate(min_candidate(1)), :);
    end
end
