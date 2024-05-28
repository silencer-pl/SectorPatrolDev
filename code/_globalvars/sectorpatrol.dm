GLOBAL_VAR_INIT(savefile_number, 0) //Savefile number reference. Should be set automatically by the persistance system. Tells it which save file is latest while loding/saving

//Round infopanel readout:

GLOBAL_VAR_INIT(ingame_location, "UACM Outer Veil Primary Supply Terminal, Neroid Sector")
GLOBAL_VAR_INIT(ingame_date, "Unknown Date/Time")
GLOBAL_VAR_INIT(ingame_time, 0)

//Persistancy lists
GLOBAL_LIST_EMPTY(turfs_saved) //turfs to be saved/loaded, ordered by xyz coordiates
GLOBAL_LIST_EMPTY(objects_saved) //objects to be saved/loaded, orderd by an index number
