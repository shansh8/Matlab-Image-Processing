clc;
close all;
v= VideoReader('E:\3 Sem\CCTV\work\vid.avi');
for im = 2780:2800;
   tic;
    a=read(v,im);
    b=read(v,im+1)
    da=double(a);
      db=double(b);
      D=imabsdiff(a,b);
      r=zeros(240,320);
      h=a;
      for ix=1:240
          for iy=1:320
              if D(ix,iy)>20
                  if da(ix,iy,1)~=0&da(ix,iy,2)~=0&da(ix,iy,3)~=0
                      if (db(ix,iy,1)/da(ix,iy,1)<4)&(db(ix,iy,1)/da(ix,iy,1)>1.5)
                          if (db(ix,iy,2)/da(ix,iy,2)<2.8)&(db(ix,iy,2)/da(ix,iy,2)>1.3)
                              if (db(ix,iy,3)/da(ix,iy,3)<2.05)&(db(ix,iy,3)/da(ix,iy,3)>1.14)
                                  if (db(ix,iy,3)/da(ix,iy,3)<db(ix,iy,1)/da(ix,iy,1))&(db(ix,iy,3)/da(ix,iy,3)<db(ix,iy,2)/da(ix,iy,2))&(db(ix,iy,2)/da(ix,iy,2)<db(ix,iy,1)/da(ix,iy,1))
                                      if abs(da(ix,iy,1)/(da(ix,iy,1)+da(ix,iy,2)+da(ix,iy,3))-db(ix,iy,1)/(db(ix,iy,1)+db(ix,iy,2)+db(ix,iy,3)))<0.129
                                          if abs(da(ix,iy,2)/(da(ix,iy,1)+da(ix,iy,2)+da(ix,iy,3))-db(ix,iy,2)/(db(ix,iy,1)+db(ix,iy,2)+db(ix,iy,3)))<0.028
                                              if abs(da(ix,iy,3)/(da(ix,iy,1)+da(ix,iy,2)+da(ix,iy,3))-db(ix,iy,3)/(db(ix,iy,1)+db(ix,iy,2)+db(ix,iy,3)))<0.143
                                                  r(ix,iy)=0;
                                                  h(ix,iy,1)=255;
                                                  h(ix,iy,2)=255;
                                                  h(ix,iy,3)=255;
                                              end
                                          end
                                      end
                                  end
                              end
                          end
                      end                    
                  end
              end
          end
      end
      imshow(h);
      im1=h-a;
      imshow(im1);

      toc;  
end