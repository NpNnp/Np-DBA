select name,
       create_date,
       modify_date
from sys.procedures
where  name in ('Cmb_branch','spDShelpdeskFollowupFirstPayment','SP_Resitribus','spDShelpdeskDistributionFirstPayment')
order by modify_date desc;

select name,
       create_date,
       modify_date
 from  sys.views
 WHERE name = 'VDSFirstPaymentFollowUp';

