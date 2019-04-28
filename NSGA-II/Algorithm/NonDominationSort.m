function [f, F] = NonDominationSort(x, M, V)

N = size(x, 1);

front = 1;

F(front).f = [];
individual = [];

for i = 1 : N
    individual(i).n = 0;
    individual(i).p = [];

    for j = 1 : N
        dom_less = 0;
        dom_equal = 0;
        dom_more = 0;

        for k = 1 : M
            if (x(i, V + k) < x(j, V + k)) 
                dom_less = dom_less + 1;
            elseif (x(i,V + k) == x(j,V + k))
                dom_equal = dom_equal + 1;
            else
                dom_more = dom_more + 1;
            end
        end

        % i dominated j
        if dom_less == 0 && dom_equal ~= M 
            individual(i).n = individual(i).n + 1;

        % j dominated i
        elseif dom_more == 0 && dom_equal ~= M 
            individual(i).p = [individual(i).p j];
        end
    end 

    % front 1
    if individual(i).n == 0
        x(i, M + V + 1) = 1; % the front saved in the last position of x
        F(front).f = [F(front).f i];
    end
end

while ~isempty(F(front).f)
   Q = [];
   for i = 1 : length(F(front).f)
       if ~isempty(individual(F(front).f(i)).p)
        	for j = 1 : length(individual(F(front).f(i)).p)
            	individual(individual(F(front).f(i)).p(j)).n = individual(individual(F(front).f(i)).p(j)).n - 1;
        	   	if individual(individual(F(front).f(i)).p(j)).n == 0
               		x(individual(F(front).f(i)).p(j),M + V + 1) = front + 1;
                    Q = [Q individual(F(front).f(i)).p(j)];
                end
            end
       end
   end
   front = front + 1;
   F(front).f = Q;
end

[~, index_of_fronts] = sort(x(:, M + V + 1));
for i = 1 : length(index_of_fronts)
    f(i, :) = x(index_of_fronts(i), :);
end