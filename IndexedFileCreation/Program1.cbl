       identification division.
       program-id. program1 as "indexedfilecreation.program1".

       environment division.
       input-output section.
       file-control.   select indexedfile
                       assign to "C:\a\exercise10\indexedmaster.txt"
                       organization is indexed   
                       access mode is random
                       record key is customer-no-indexed.

                       select seqfile
                       assign to "C:\a\exercise10\seqfile.txt"
                       organization is line sequential.
      

       data division.
       file section.
       fd  indexedfile.
       01  indexedfile-record.
           05  customer-no-indexed           picture x(5).
           05  customer-name-indexed         picture x(20).
           05  date-of-purchase-indexed      picture 99/99/9999.
           05  amt-of-purchase-indexed       picture 9(5)v99.


       fd  seqfile.
       01  seqfile-record.
           05  customer-no-seq           picture x(5).
           05  customer-name-seq         picture x(20).
           05  date-of-purchase-seq      picture 99/99/9999.
           05  amt-of-purchase-seq       picture 9(5)v99.



       working-storage section.
       01  eof     picture x value "N".

       procedure division.
       main-module.
           open input seqfile
           open output indexedfile

           perform until eof = "Y"
               read seqfile 
                   at end set eof to "Y"
               end-read
               write indexedfile-record from seqfile-record
                   invalid key
                       display "error on write"
                   not invalid key
                       display "record added"
               end-write
           end-perform

       close seqfile, indexedfile
       stop run.