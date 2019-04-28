function f  = ReplaceChromosome(intermediate_chromosome, M, V,pop)

[N, ~] = size(intermediate_chromosome);

% Get rank index
[~, index] = sort(intermediate_chromosome(:, M + V + 1));

for i = 1 : N
    sorted_chromosome(i, :) = intermediate_chromosome(index(i), :);
end

max_rank = max(intermediate_chromosome(:, M + V + 1));

previous_index = 0;
for i = 1 : max_rank
    % Find current rank last index
    current_index = find(sorted_chromosome(:, M + V + 1) == i, 1, 'last');

    if current_index > pop
        % cut
        remaining = pop - previous_index;
        temp_pop = sorted_chromosome(previous_index + 1 : current_index, :);
        [~, temp_sort_index] = sort(temp_pop(:, M + V + 2), 'descend');

        for j = 1 : remaining
            f(previous_index + j,:) = temp_pop(temp_sort_index(j),:);
        end
        return;
        
    elseif current_index < pop
        % Add all
        f(previous_index + 1 : current_index, :) = sorted_chromosome(previous_index + 1 : current_index, :);
    else
        % Add all and return
        f(previous_index + 1 : current_index, :) = sorted_chromosome(previous_index + 1 : current_index, :);
        return;
    end
    
    % Get the index for the last added individual.
    previous_index = current_index;
end
