PRAGMA foreign_keys = ON;

drop table if exists ra_probe;
create table ra_probe (
		probeid			         INTEGER	  NOT NULL	PRIMARY KEY
  , timestamp            INTEGER    NOT NULL
	,	hardware		         TEXT
	,	hardware_version		 TEXT
	,	webpage			         TEXT
);

drop table if exists ra_probe_api;
create table ra_probe_api (

		probeid					INTEGER	 	NOT NULL	PRIMARY KEY
  , timestamp       INTEGER   NOT NULL
  , day             INTEGER

	,	is_public				BOOLEAN
	,	is_anchor				BOOLEAN

	,	address_v4			TEXT
	,	address_v6			TEXT
	,	prefix_v4				TEXT
	,	prefix_v6				TEXT
  ,	asn_v4					INTEGER
	,	asn_v6					INTEGER

	,	status					INTEGER     /* 0, 1, 2 */
	,	status_name			TEXT        /* CONNECTED, DISCONNECTED, ABANDONED */
	,	status_since		INTEGER

	,	latitude				REAL
	,	longitude				REAL
	,	country_code		TEXT

  , tags            TEXT
  , resource_uri    TEXT

  , FOREIGN KEY ( probeid ) REFERENCES ra_probe ( probeid ) ON DELETE CASCADE
);

drop table if exists ra_asn;
create table ra_asn (
		asn                       INTEGER	 	  PRIMARY KEY
  , timestamp                 INTEGER     NOT NULL
	,	asn_holder_name           TEXT
  , asn_access_type           TEXT
	,	network_type              TEXT
);

drop table if exists sk_asn;
create table sk_asn (
		asn                       INTEGER	 	  PRIMARY KEY
  , timestamp                 INTEGER     NOT NULL
	,	asn_holder_name           TEXT
  , asn_access_type           TEXT
	,	network_type              TEXT
);

drop table if exists ra_one_off;
create table ra_one_off (

		msm_id												INTEGER		NOT NULL  PRIMARY KEY
	,	asn_v4												INTEGER		NOT NULL  UNIQUE
);

drop table if exists ra_one_off_parameters;
create table ra_one_off_parameters (

		af														INTEGER
	,	dst_addr											TEXT
	,	dst_name											TEXT
	,	endtime												INTEGER			NOT NULL     /* TIMESTAMP */
	,	probe_ip											TEXT	                   /* from field in json */
	, fw														INTEGER
	, group_id											INTEGER
	,	lts														INTEGER
	, msm_id												INTEGER		NOT NULL
	, msm_name											TEXT
	,	paris_id											INTEGER
	,	probeid												INTEGER		NOT NULL
	,	proto													TEXT

	,	packet_size										INTEGER
	,	src_addr											TEXT
	,	starttime											INTEGER
	, msm_type											TEXT

	,	result_hop_no 								INTEGER		NOT NULL
	, result_hop_blob								TEXT

  , PRIMARY KEY ( msm_id, probeid, endtime, result_hop_no)
  , FOREIGN KEY ( msm_id ) REFERENCES ra_one_off ( msm_id ) ON DELETE CASCADE
);

drop table if exists ra_one_off_extensions;
create table ra_one_off_extensions (

		probeid												INTEGER		PRIMARY KEY
  , timestamp                     INTEGER   NOT NULL
	, if_residential                BOOLEAN
	, if_nat                        BOOLEAN
	, access_type_technology        TEXT
  , reverse_dns                   TEXT
  , FOREIGN KEY ( probeid ) REFERENCES ra_probe_api ( probeid ) ON DELETE CASCADE
);

drop table if exists ra_traceroute;
create table ra_traceroute (

		msm_id												INTEGER		NOT NULL  PRIMARY KEY
	,	asn_v4												INTEGER		NOT NULL  UNIQUE
);

drop table if exists ra_traceroute_parameters;
create table ra_traceroute_parameters (

		af														INTEGER
	,	dst_addr											TEXT
	,	dst_name											TEXT
	,	endtime												INTEGER			NOT NULL     /* TIMESTAMP */
	,	probe_ip											TEXT	                   /* from field in json */
	, fw														INTEGER
	, group_id											INTEGER
	,	lts														INTEGER
	, msm_id												INTEGER		NOT NULL
	, msm_name											TEXT
	,	paris_id											INTEGER
	,	probeid												INTEGER		NOT NULL
	,	proto													TEXT

	,	packet_size										INTEGER
	,	src_addr											TEXT
	,	starttime											INTEGER
	, msm_type											TEXT

	,	result_hop_no 								INTEGER		NOT NULL
	, result_hop_blob								TEXT

  , PRIMARY KEY ( msm_id, probeid, endtime, result_hop_no)
  , FOREIGN KEY ( msm_id ) REFERENCES ra_traceroute ( msm_id ) ON DELETE CASCADE
);

drop table if exists ra_latencies;
create table ra_latencies (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL
  , h1_latencies                  TEXT
  , h2_latencies                  TEXT

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists ra_latencies_agg;
create table ra_latencies_agg (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL

  , h1_min                        REAL
  , h2_min                        REAL

  , h1_q1                         REAL
  , h2_q1                         REAL

  , h1_median                     REAL
  , h2_median                     REAL

  , h1_q2                         REAL
  , h2_q2                         REAL

  , h1_max                        REAL
  , h2_max                        REAL

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists ra_latencies_last_hop;
create table ra_latencies_last_hop (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL
  , last_hop                      INTEGER
  , last_hop_latencies            REAL

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists ra_latencies_last_hop_agg;
create table ra_latencies_last_hop_agg (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL

  , last_hop                      INTEGER
  , last_hop_min                  REAL
  , last_hop_q1                   REAL
  , last_hop_median               REAL
  , last_hop_q2                   REAL
  , last_hop_max                  REAL

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists sk_latencies_agg;
create table sk_latencies_agg (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL
  , h1_avg                        REAL
  , h2_avg                        REAL

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists sk_latencies_last_hop_agg;
create table sk_latencies_last_hop_agg (

		probeid												INTEGER		NOT NULL
	,	timestamp    									INTEGER   NOT NULL
  , last_hop                      INTEGER
  , last_hop_avg                  REAL

  , PRIMARY KEY ( probeid, timestamp )
);

drop table if exists metadata_snapshot;
create table metadata_snapshot (
    id                            INTEGER   PRIMARY KEY
  , isp                           TEXT
  , product                       INTEGER
  , last_seen                     TEXT
  , public_ip                     TEXT
);

drop table if exists metadata_snapshot_extensions;
create table metadata_snapshot_extensions (
    probeid                       INTEGER   PRIMARY KEY
  , asn                           INTEGER

  , FOREIGN KEY ( probeid ) REFERENCES metadata_snapshot ( id ) ON DELETE CASCADE
);

drop table if exists unit_report;
create table unit_report (
    unit_id                       INTEGER
  , country                       TEXT
  , city                          TEXT
  , region                        TEXT
  , isp_id                        INTEGER
  , maxmind_isp                   TEXT
  , maxmind_org                   TEXT
  , latitude                      REAL
  , longitude                     REAL
  , speed                         INTEGER
  , upload_speed                  INTEGER
  , public_ip                     TEXT
  , active                        INTEGER
  , dtime                         TEXT
);

drop table if exists curr_traceroute;
create table curr_traceroute (
    unit_id                       INTEGER           NOT NULL DEFAULT '0'
  , dtime                         TEXT              NOT NULL DEFAULT '0000-00-00 00:00:00'
  , target                        TEXT              NOT NULL DEFAULT ''
  , address                       TEXT
  , protocol                      TEXT
  , hop                           INTEGER           NOT NULL DEFAULT '0'
  , hop_address                   TEXT
  , hop_name                      TEXT
  , sent                          INTEGER
  , received                      INTEGER
  , rtt_avg                       INTEGER
  , successes                     INTEGER
  , failures                      INTEGER
  , location_id                   INTEGER           NOT NULL DEFAULT '0'
);

drop table if exists sk_one_off_extensions;
create table sk_one_off_extensions (

		probeid												INTEGER		PRIMARY KEY
  , timestamp                     INTEGER   NOT NULL
	, if_residential                BOOLEAN
	, if_nat                        BOOLEAN
	, access_type_technology        TEXT
  , reverse_dns                   TEXT
  , FOREIGN KEY ( probeid ) REFERENCES curr_traceroute ( unit_id ) ON DELETE CASCADE
);

