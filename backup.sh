#! /bin/bash
rsync -avz --files-from=backup_list ~ .
