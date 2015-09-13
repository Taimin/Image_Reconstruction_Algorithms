%phase correltaion implementation

moved=rgb2gray(imread('fix.png'));
fix=rgb2gray(imread('moved.png'));

imshowpair(fix,moved,'montage');

fft_fix=fft2(fix,182,182);
fft_moved=fft2(moved,182,182);

fft_C=fft_fix.*conj(fft_moved)./abs(fft_fix.*conj(fft_moved));

C=abs(ifft2(fft_C));

[M,I]=max(C(:));
[C_row, C_col] = ind2sub(size(C),I);
figure,imshow(C,[]);

moved_trans=imtranslate(moved,[C_row,C_col]);

imshowpair(moved_trans,fix);