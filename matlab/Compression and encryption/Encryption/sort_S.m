function [index] = sort_S(X)
%SORT_S 此处显示有关此函数的摘要
%   此处显示详细说明
    % A = [123 32 45 165 177];
    % B = [67 34 126 22 43];
    S_B = X;
    L=length(X);
    R_AB = zeros(1,L);
    for n = 1:L
        R_AB(n) =floor(S_B(n)) + n/(L+n);
    end
    R_AB_sort = sort(R_AB);
    
    % for n = 1:L
    %     R_ab_sort = R_AB_sort(n);
    %     for m = 1:L
    %         if R_ab_sort == R_AB(m)
    %             E_AB(n)=m;
    %         end
    %     end
    % end
    [~, index] = ismember(R_AB_sort, R_AB);
end

