function [DNA_Xor_Result] = DNA_diffusion(DNA_Code1, DNA_Code2, rule)
%DNA_DIFFUSION 用规则rule进行两个DNA序列运算
%   rule = 1, 2, 3, 4代表加，减，异或，同或
    if rule == 1 || rule == 2                                                            %加法,规则1
        if DNA_Code1=='A'
            DNA_Xor_Result=DNA_Code2;
        elseif DNA_Code1=='T'
            if DNA_Code2=='A'
                DNA_Xor_Result='T';
            elseif DNA_Code2=='T'
                DNA_Xor_Result='A';
            elseif DNA_Code2=='C'
                DNA_Xor_Result='G';
            else
                DNA_Xor_Result='C';
            end
        elseif DNA_Code1=='C'
            if DNA_Code2=='A'
                DNA_Xor_Result='C';
            elseif DNA_Code2=='T'
                DNA_Xor_Result='G';
            elseif DNA_Code2=='C'
                DNA_Xor_Result='A';
            else
                DNA_Xor_Result='T';
            end
        else
            if DNA_Code2=='A'
                DNA_Xor_Result='G';
            elseif DNA_Code2=='T'
                DNA_Xor_Result='C';
            elseif DNA_Code2=='C'
                DNA_Xor_Result='T';
            else
                DNA_Xor_Result='A';
            end
        end
%     elseif rule == 2                                                        %减法,规则1
%         if DNA_Code2=='A'
%             DNA_Xor_Result=DNA_Code1;
%         elseif DNA_Code2=='T'
%             if DNA_Code1=='A'
%                 DNA_Xor_Result='G';
%             elseif DNA_Code1=='T'
%                 DNA_Xor_Result='A';
%             elseif DNA_Code1=='C'
%                 DNA_Xor_Result='T';
%             else
%                 DNA_Xor_Result='C';
%             end
%         elseif DNA_Code2=='C'
%             if DNA_Code1=='A'
%                 DNA_Xor_Result='C';
%             elseif DNA_Code1=='T'
%                 DNA_Xor_Result='G';
%             elseif DNA_Code1=='C'
%                 DNA_Xor_Result='A';
%             else
%                 DNA_Xor_Result='T';
%             end
%         else
%             if DNA_Code1=='A'
%                 DNA_Xor_Result='T';
%             elseif DNA_Code1=='T'
%                 DNA_Xor_Result='C';
%             elseif DNA_Code1=='C'
%                 DNA_Xor_Result='G';
%             else
%                 DNA_Xor_Result='A';
%             end
%         end
    elseif rule == 3                                                %异或,规则4
        if DNA_Code1 == DNA_Code2
            DNA_Xor_Result = 'C';                                           %相等异或结果全为C
        elseif (DNA_Code1=='C' && DNA_Code2=='A') || (DNA_Code1=='A' && DNA_Code2=='C') || (DNA_Code1=='G' && DNA_Code2=='T') || (DNA_Code1=='T' && DNA_Code2=='G')
            DNA_Xor_Result = 'A';  %A
        elseif (DNA_Code1=='T' && DNA_Code2=='A') || (DNA_Code1=='A' && DNA_Code2=='T') || (DNA_Code1=='G' && DNA_Code2=='C') || (DNA_Code1=='C' && DNA_Code2=='G')
            DNA_Xor_Result = 'G';  %G
        else
            DNA_Xor_Result = 'T';  %T
        end
    else                                                                    %同或,规则7
        if DNA_Code1 == DNA_Code2
            DNA_Xor_Result = 'A';
        elseif (DNA_Code1=='T' && DNA_Code2=='A') || (DNA_Code1=='A' && DNA_Code2=='T') || (DNA_Code1=='G' && DNA_Code2=='C') || (DNA_Code1=='C' && DNA_Code2=='G')
            DNA_Xor_Result = 'T';
        elseif (DNA_Code1=='C' && DNA_Code2=='A') || (DNA_Code1=='A' && DNA_Code2=='C') || (DNA_Code1=='G' && DNA_Code2=='T') || (DNA_Code1=='T' && DNA_Code2=='G')
            DNA_Xor_Result = 'C';
        else
            DNA_Xor_Result = 'G';
        end
    end
    
end

