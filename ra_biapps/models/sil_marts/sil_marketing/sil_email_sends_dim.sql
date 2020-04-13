{% if not var("enable_mailchimp_email_source") or (not var("enable_marketing_warehouse")) %}
{{
    config(
        enabled=false
    )
}}
{% else %}
{{
    config(
        unique_key='send_pk',
        alias='email_sends_dim'
    )
}}
{% endif %}

WITH sends AS
  (
  SELECT * from {{ ref('sde_email_sends_ds') }}
)
select GENERATE_UUID() as send_pk,
       s.*
from sends s
