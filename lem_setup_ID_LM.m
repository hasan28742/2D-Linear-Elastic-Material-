function  d=lem_setup_ID_LM(d)
%flag will be check and a value 1 will be assinged to L matrix
lem_include_flags;


count = 0; count1 = 0;   
for i = 1:neq
    if flags(i) == 2            % check if essential B.C   
        count   = count + 1;    
        ID(i)   = count;        % arrange essential B.C nodes first
        d(count)= e_bc(i);      % store reordered essential B.C 
    else
        count1 = count1 + 1;
        %ID(i) = nd + count1;    %number of nodes in essential boundary nd=9 for heat; nd=5 for material 16elements 2 for 1 elements
        %ID(i) = nd*ndof + count1;
        ID(i) = nd*ndof + count1;
        %heat= i=7, flag=0 so nd+count=9+1=10___ID
        %heat= i=11, flag=2 so ID(i)=ID(7)=7___ID
    end
end

ID
%{
for i = 1:nel %16
    for j = 1:nen % node per element=4
        LM(j,i)=ID(IEN1(j,i));   % create the LM matrix size= per element node *element number =4*16
    end
end
%}
for i = 1:nel %16
    row=1; % initiate a counter
    %frist iteration row 1
    for j = 1:nen % node per element=4
        nodedofs=ndof*(IEN(j,i)-1);
        for k=1:ndof
            LM(row,i)=ID(nodedofs + k );   % create the LM matrix size= per element node *element number =4*16
            row= row + 1;
        end
    end
end
