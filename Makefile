reload :
	dbmate down
	dbmate up

reset :
	dbmate drop
	dbmate up

create :
	dbmate new create_$(name)_table

modify :
	dbmate new modify_$(name)_table

up :
	dbmate up

down :
	dbmate down