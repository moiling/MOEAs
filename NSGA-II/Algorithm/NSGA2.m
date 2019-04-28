function NSGA2(pop, gen)
    %% Initialize Problem
    [M, V, min_range, max_range] = InitialZDT6(); % ZDT6

    %% Initialize Variables
    for i = 1 : pop
        for j = 1 : V
            % random variables
            chromosome(i, j) = min_range(j) + (max_range(j) - min_range(j)) * rand(1);
        end
        % objectives
        chromosome(i, V + 1: V + M) = CalculateZDT6(chromosome(i,:)); % ZDT6
    end

    %% Non Domination Sort
    [chromosome, F] = NonDominationSort(chromosome, M, V);

    %% Crowding Distance Sort
    chromosome = CrowdingDistance(chromosome, F, M, V);
    
    %% evolution process
    for i = 1 : gen
        
        pool = round(pop / 2);

        % Binary Tournament Selection
        parent_chromosome = BinaryTournamentSelection(chromosome, pool);
        
        % Genetic Operator
        offspring_chromosome = GeneticOperator(parent_chromosome, M, V, 20, 20, min_range, max_range);

        main_pop = size(chromosome, 1);
        offspring_pop = size(offspring_chromosome, 1);

        % Intermediate
        intermediate_chromosome(1: main_pop, :) = chromosome;
        intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M + V) = offspring_chromosome;

        % Non Domination Sort and Crowding Distance Sort
        [intermediate_chromosome, F] = NonDominationSort(intermediate_chromosome, M, V);
        intermediate_chromosome = CrowdingDistance(intermediate_chromosome, F, M, V);

        % Perform Selection
        chromosome = ReplaceChromosome(intermediate_chromosome, M, V, pop);

        % Show current process
        clc
        fprintf('%d generations completed\n', i);

    end
    
    %% Result
    % save solution.txt chromosome -ASCII

    %% Visualize

    % The size of the figure
    set(gca,'Unit','pixels');
    if get(gca,'Position') <= [inf inf 400 300]
        Size = [3 5 .8 8];
    else
        Size = [6 8 2 13];
    end

    % The styple of the figure
    if M == 2
        varargin = {'ok','MarkerSize',Size(1),'Marker','o','Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]};
    elseif M == 3
        varargin = {'ok','MarkerSize',Size(2),'Marker','o','Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]};
    elseif M > 3
        varargin = {'Color',[.5 .5 .5],'LineWidth',Size(3)};
    end

    if M == 2
        plot(chromosome(:, V + 1),chromosome(:, V + 2), varargin{:});
        xlabel('\itf\rm_1'); ylabel('\itf\rm_2');
        set(gca,'XTickMode','auto','YTickMode','auto','View',[0 90]);
        axis tight;
    elseif M ==3
        plot3(chromosome(:, V + 1),chromosome(:, V + 2),chromosome(:,V + 3), varargin{:});
                plot3(Data(:,1),Data(:,2),Data(:,3),varargin{:});
        xlabel('\itf\rm_1'); ylabel('\itf\rm_2'); zlabel('\itf\rm_3');
        set(gca,'XTickMode','auto','YTickMode','auto','ZTickMode','auto','View',[135 30]);
        axis tight;
    end