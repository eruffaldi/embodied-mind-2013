# embodied-mind-2013
Software for analyzing the data acquired during the Embodied Mind 2013 at Gargonza 


Instructions for the use of the data
------------------------------------


(1) build the datasets
    dsexp_buildds

(2) load the dataset

load Subject6_UsbDS
load Subject6_VicNautilusDS

dsu
     stime       vtime     usbgsr           gsr    seeg         
    0.034044    3.1265    [1x16 double]    0      [1x16 double]

vic

    ttime     frame    vtime       event
    6.0776    1        0.061503    0    

(3) description

dsu
    stime - simulink time in Usb device
    vtime - vicon time RECEIVED
    usbgsr - usbgsr measure 16 values
    gsr   - computed gsr
    seeg  - measurd EEG from eeg

vic
    ttime - UNKNOWN
    frame  - vicon frame
    vtime - vicon time
    event - stored event


(4) synchronization
EEG timings:
    setime
    tetime

USB+VICON
    link the vtime in dsu with the frame in vic

    (a) extract vicon frame

        dsu.frame = e.frame + floor((dsu.setime-e.setime)/vdt);

    (b) match event

        dsu.event = interp1fwd(vic.frame,vic.event,dsu.frame);
    
    (c) transfer setime to vicon


Subject 6:
dsu.frame is ok but not dsu.event