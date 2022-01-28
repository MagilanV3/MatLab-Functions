Sample1 = imread('Sample 1.png');
Sample2 = imread('Sample 2.png');
Sample3 = imread('Sample 3.png');
Sample4 = imread('Sample 4.png');
Sample5 = imread('Sample 5.png');
Unknown = imread('Unknown.png');

Mean1 = mean(Sample1, [1 2]);
Mean2 = mean(Sample2, [1 2]);
Mean3 = mean(Sample3, [1 2]);
Mean4 = mean(Sample4, [1 2]);
Mean5 = mean(Sample5, [1 2]);
MeanUnknown = mean(Unknown, [1 2]);

MeanSimilar1 = 1 - abs((Mean1 - MeanUnknown)./255);
MeanSimilar2 = 1 - abs((Mean2 - MeanUnknown)./255);
MeanSimilar3 = 1 - abs((Mean3 - MeanUnknown)./255);
MeanSimilar4 = 1 - abs((Mean4 - MeanUnknown)./255);
MeanSimilar5 = 1 - abs((Mean5 - MeanUnknown)./255);

AllSimilar = [MeanSimilar1 MeanSimilar2 MeanSimilar3 MeanSimilar4 MeanSimilar5];

MeanAllSimilar = mean(AllSimilar, 3);

MaxIndex = 0;
MaxValue = 0;
for i=1:5
    if MaxValue < MeanAllSimilar(i)
        MaxValue = MeanAllSimilar(i);
        MaxIndex = i;
    end
end

disp([MaxIndex MaxValue])

if MaxIndex < 4
    disp('Healthy')
elseif MaxIndex < 5
    disp('Prediabetic')
else
    disp('Diabetic')
end