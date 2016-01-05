PRO KML_NDVI, input_location, output_location
  compile_opt idl2

  ; Init ENVI Application
  e = ENVI(HEADLESS=1)
  e.LOG_FILE = output_location + 'batch.txt'

  files = File_Search(input_location, '*.til', /FULLY_QUALIFY_PATH)
  file_list_size = N_ELEMENTS(files)

  FOR i=0, file_list_size-1 DO BEGIN
    Print, 'IMAGE: ', files[i]
    raster = e.OpenRaster(files[i])

    Task = ENVITask('SpectralIndex')
    Task.INPUT_RASTER = raster
    Task.INDEX = 'Normalized Difference Vegetation Index'
    Task.OUTPUT_RASTER_URI = output_location + STRTRIM(STRING(i), 1) + '_output'

    ; Run the task
    Task.Execute

    output_path = output_location + STRTRIM(STRING(i), 1) + '_output'

    raster2 = e.OpenRaster(Task.OUTPUT_RASTER)

    e.ExportRaster, raster2, output_path+'.tif', "TIFF"

  END
END
