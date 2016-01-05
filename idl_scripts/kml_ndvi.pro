
pro KML_NDVI, input_location, output_location;, sli;, aoi
  compile_opt idl2
  CD, input_location
  ; ; ; ; ;
  ; Batch sript to process imagery for NDVI
  ; KML 04/13/15
  ; fname = input filenames (.txt)
  ; out_location = path to output files
  ; ; ; ; ;

  ; Hard coded local path names for testing purposes
  ;fname = 'C:\Working Folder\Projects\Shell\Imagery\Test\test_input_images2.txt'
  ;output_location = 'C:\Working Folder\Projects\Shell\Results\Temp\'

  ;
  ;first restore all base save files
  ;
  envi, /restore_base_save_files
  ;
  ;Initialize ENVI and send all errors and warnings to the file batch.txt
  ;
  envi_batch_init, log_file = output_location + 'batch.txt', /NO_STATUS_WINDOW
  ; Select a text file and open for reading
  fname = input_location + 'images/image_list.txt'
  OPENR, lun, fname, /GET_LUN
  ; Read one line at a time, saving the result into array
  array = ''
  line = ''

  Print, File_Search(input_location + '005606990010_01_P011_MUL/', '*', /FULLY_QUALIFY_PATH)

  WHILE NOT EOF(lun) DO BEGIN & $
    READF, lun, line & $
    array = [array, line] & $
  ENDWHILE
; Close the file and free the file unit
FREE_LUN, lun
fname = array[1:(n_elements(array)-1)]
  ; open the appropriate datasets
  n_images = n_elements(fname)
  image_fids = lonarr(n_images)
  image_dims = intarr(n_images, 6)
  image_pos = intarr(n_images)
  for i = 0, n_images-1 do begin
      print, 'Reading in image:', fname[i]
      envi_open_file, fname[i], /no_interactive_query, /no_realize, r_fid = r_fid
      image_fids[i] = r_fid
      envi_file_query, image_fids[i], nb = nb, ns = ns, nl = nl
      image_dims[i, *] = [i, -1, 0, ns-1, 0, nl-1]
      image_pos[i] = nb
  endfor
  print, 'Image FIDs:', Image_FIDs
  print, 'image #1 DIMS:', image_dims[0, *]
  ; image_fids now contains file IDs for input images

  ; NDVI Section
  print, 'Performing NDVI'
  ndvi_fid = intarr(n_images)

  ; perform ndvi
  for i = 0, n_images-1 do begin
    ; assumes input files are of type 'tif'
    BaseName = file_basename(fname[i], '.tif')
    out_name = output_location+strcompress('file_'+string(i+1), /remove_all)
    envi_file_query, image_fids[i], dims = dims
    print, 'out_name:', out_name
    ENVI_DOIT, 'NDVI_DOIT', /CHECK, DIMS=image_dims[i, 1:5], FID=image_fids[i], OUT_BNAME='NDVI', OUT_DT=4, OUT_NAME=out_name, POS=[7, 5], R_FID=r_fid
      ; 'r_fid' now exists
    NDVI_fid[i] = r_fid

    ; close leftover files
    envi_file_mng, id = r_fid, /delete

  endfor



  end
