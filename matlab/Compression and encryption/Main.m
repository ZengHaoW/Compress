clear;clc;

test = [103 99 98 103 93 82 78 81]

a = [6     1     7     6     6     6     4     4];
b =a;
% b = [ 1     5     8     1     6     1     3     7];
% a = [3 3 4 1 1 2 1 1];
% b = [3 3 4 1 1 2 1 1];
% c = [221 53 207 211 210 166 218 72];
c = [221    53   100   211   210   166   218    72];
x = [ 4     2     2     1     1     3     2     1];
% x = [4     4     2     3     1     4     2     2];
test_DNA = ones(1, 8 * 4);
c_DNA = ones(1, 8 * 4);
test_DNA(1:4) = DNAEncoding(test(1), a(1));
c_DNA(1:4) = DNAEncoding(c(1), a(1));

for i = 2: 8
    test_DNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(test(i), a(i));
    c_DNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(c(i), a(i));
end

seqDNA_Xor = ones(1, 8 * 4);
for i = 1: 8 * 4
    if i <= 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i));
    elseif i <= 2 * 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 8));
    elseif i <= 3 * 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 2*8));
    else
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 3*8));
%     else
%         seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 4 * n));
    end
end

%DNA解密
seqAfterDNA = ones(1, 8);
for i = 1: 8
    if i == 1
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(1: 4), b(i));
    else
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(4 * (i - 1) + 1: 4 * i), b(i));
    end
end
seqAfterDNA


% b = [6     1     7     6     6     6     4     4];
% a = [ 1     5     8     1     6     1     3     7];

test_DNA(1:4) = DNAEncoding(seqAfterDNA(1), a(1));
c_DNA(1:4) = DNAEncoding(c(1), a(1));
for i = 2: 8
    test_DNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(seqAfterDNA(i), a(i));
    c_DNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(c(i), a(i));
end

seqDNA_Xor = ones(1, 8 * 4);
for i = 1: 8 * 4
    if i <= 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i));
    elseif i <= 2 * 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 8));
    elseif i <= 3 * 8
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 2*8));
    else
        seqDNA_Xor(i) = DNA_diffusion(test_DNA(i), c_DNA(i), x(i - 3*8));
%     else
%         seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 4 * n));
    end
end

%DNA解密
seqAfterDNA = ones(1, 8);
for i = 1: 8
    if i == 1
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(1: 4), b(i));
    else
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(4 * (i - 1) + 1: 4 * i), b(i));
    end
end
seqAfterDNA
isequal(seqAfterDNA, test)