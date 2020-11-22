%Instruction Postulate Simulation - Devansh Bhardwaj%
%This Matlab code runs simulation of 
%Mermins Postulate about Information Set
%Instruction set will store the number of times an Instruction is passed%
Instruction_Set = zeros([1 8]);
% Run can be changed according to the number of times one want's to run the
% simulation
Run = 1000000;
%Observatin Cell stores the Result of each Simulation%
Observations =cell(1,Run);
%Table1 stores the outcome for each switch settings 
Table1 = zeros([9 6]);
%Table2 stores the switch setting for Alice and Bob as well 
%As the Light that flased on the screen
Table2 = [repmat({0},5,3)];
%This loop is used to label switch setting on 
%Table1 and Table 2 for better visualisation of the resut
for i = 1:3
    Table2{2+i,1}=i;
    for j = 1:3
        Table1(3*(i-1)+j, 1)=i;
        Table1(3*(i-1)+j,2)=j;
    end
end
Table2{1,1}='R';
Table2{2,1}='G';
%This for Loop is Used for simulation of the results
for i=1:Run
    %Generate a random instruction set Instead of 1 to 6, 0 to 7 can also
    %be used if we are considering RRR and GGG to be the instruction set as
    %well
     y = (randi([1 6],1));
    %Increments the instruction passed on
    Instruction_Set(y+1)=Instruction_Set(y+1)+1;
    %converts y from decimal to 3 bits binary number
    % 2 will be reprsented as 010 and the instruction set would be RGR 5
    % will be 101 and instruction set would be GRG
    y = de2bi(y,3);%Matrix form will be converted to string in next step
    str = string(y(1,1));
    str = append(str,string(y(1,2)));
    str = append(str,string(y(1,3)));
    %Generating random Switch setting for Alice and Bob
    A = int32(randi([1 3],1));B = int32(randi([1 3],1));
    %A_C & B_C stores the Light corresponding to the switch setting
    %generated above.
    A_C =y(1,A);B_C = y(1,B);
    %Storing Results in the Table 1 and Table 2
    row = (A-1)*3+B;col = 3+(2*A_C+B_C);
    Table1(row,col)= Table1(row,col)+1;
    Table2{A_C+1,2}= Table2{A_C+1,2}+1;
    Table2{B_C+1,3}= Table2{B_C+1,3}+1;
    Table2{A+2,2}= Table2{A+2,2}+1;
    Table2{B+2,3}= Table2{B+2,3}+1;
    %temp is used to combine the result of switches and light
    %ALice switch 1 and light red and with Bob's switch 2 and light Green
    %temp will be 12RG
    temp = string(A);
    temp = append(temp,string(B));
    if(A_C)
        temp = append(temp,'G');
    else 
        temp = append(temp,'R');
    end
    if(B_C)
        temp = append(temp,'G');
    else
        temp = append(temp,'R');
    end
    Observations{1,i}=temp;
end
%Converting values into ratio Occurance/Total Cases
sum = 0;
%No of time RR and GG were flashed and RG and GR flashed
same_colour = 0;different_colour = 0;
%Ratio in Table 1
%Iterating over row
Table1
for i = 1:9
    sum=0;%Stores no of times switch setting 12 or 11 took place
    %Iterating in columns of Table 1
    for j = 3:6
        if(j==4||j==5)
            different_colour = different_colour + Table1(i,j);
        else
            same_colour = same_colour + Table1(i,j);
        end
        sum = sum+ Table1(i,j); 
    end
    %Converting results into ratio
    for j = 3:6
        Table1(i,j) = Table1(i,j)/sum;
    end
end
%Repeating the steps in previous Table1 to Table 2
%Iterating over column
for i = 2:3
    sum=0;
    %Iterating from row 1 to row 2 i.e. Total R/G colour flash for Alice
    for j =1:2
        sum = sum + Table2{j,i};
    end
    %Determing the ratio
    for j =1:2
        Table2{j,i}= Table2{j,i}/sum;
    end
    %Iterating from row 3 to 5 i.e Total 1,2,3 switch setting for Alice
    sum=0;
    for j = 3:5
       sum = sum + Table2{j,i};
    end
    for j = 3:5
       Table2{j,i}= Table2{j,i}/sum;
    end
end
%Printing the results
header={}
Table1
Table2
same_colour
different_colour