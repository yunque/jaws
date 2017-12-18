aws rds create-db-instance \
    --db-instance-identifier mydbinstance \
    --db-instance-class db.m1.small \
    --engine postgres \
    --allocated-storage 20 \
    --master-username masterawsuser \
    --master-user-password masteruserpassword \
    --backup-retention-period 3
