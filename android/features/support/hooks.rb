Before do
  @totalScanValues = 0
  @numberOfScans = 0  
  @addedNotes = false
end

After do
  if @addedNotes == true
    dbResult = `adb -s '#{$UDID}' shell "sqlite3 /data/data/com.utang.apollo.app.debug/files/apollo.db" \ "delete from notes;"`
  end
end
