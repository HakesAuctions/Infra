locals {
  dns_records = {
    "mx" = {
      name    = ""
      type    = "MX"
      records = ["10 hakes-com.mail.protection.outlook.com."]
    },
    "emailer" = {
      name    = "emailer"
      type    = "A"
      records = ["207.114.32.104"]
    },
    "auctions" = {
      name    = "auctions"
      type    = "CNAME"
      records = ["hosted-content.aweber.com."]
    },
    "consignment" = {
      name    = "consignment"
      type    = "CNAME"
      records = ["hosted-content.aweber.com."]
    },
    "_base_txt" = {
      name = ""
      type = "TXT"
      records = [
        # Microsoft 365 Support
        "MS=ms42101813",

        # Google Verification
        "google-site-verification=q6MCW1272pO26jA_tqDZLmPbWTv3_AYbuajvWgi-mp0",

        # Knowbe4 Verification
        "knowbe4-site-verification=4a20325f993d226467366bab06c122e3",

        # SPF Record
        "v=spf1 ip4:207.114.32.0/24 ip4:207.114.33.0/24 include:spf.protection.outlook.com include:send.aweber.com ~all",
      ]
    },
    "domainkey" = { # DomainKey policy for hakes.com
      name    = "_domainkey"
      type    = "TXT"
      records = ["o=~; r=admin@diamondcomics.com"]
    },
    "adsp_domainkey" = { # ADSP policy for diamondcomics.com
      name    = "_adsp._domainkey"
      type    = "TXT"
      records = ["dkim=unknown"]
    },
    "default_domainkey" = { # DomainKey selector default for hakes.com
      name    = "default._domainkey"
      type    = "TXT"
      records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDH9mBJridGUuTexzFfNYI2frIpV7oib7axdaThpqRWPZpDQlbAeYn5Y5G67bIBaLX6WsHVQvIqUt1bLE8/uPQj/uUuSdc8zt1iZPB6ZOZxpiTZ3tDVE7PH/+FmDx07zCaZ2Zblx4VQwewcTZxzl/uR49asQWVCQ0uwvG3RJTLvBQIDAQAB"]
    },
    "domainkey_dynect_net" = { # Add DK for dynect.net
      name    = "190981_606546541d3e032eff1915b7349a0b92._domainkey"
      type    = "TXT"
      records = ["v=DKIM1; k=rsa; t=y; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIPljCW9YZhomHSVtLDvm2vAfE8Ctha0GQxD8NYj1G3VPXAL9ajhQGiABV/8MQ3SgkC1b319PiKrRvvKoyXfKCjhheklZk8dmRSDi/nH5oKnzfi3TpXv/pgA+n4xcH8/dUDtdWRQFPGCz0ztyXSCPUc1A4+YasP6eaD3fZqo0uiQIDAQAB;"]
    },
    "aweber_dmarc" = { # Aweber DMARC
      name    = "_dmarc"
      type    = "TXT"
      records = ["v=DMARC1; p=none; pct=100; rua=mailto:dmarc@fbl.optin.com"]
    },

    "domain_control_cname" = { # Domain Control  CNAME
      name    = "_7484FF77CD04CBFB3EA30F088E6DBE04"
      type    = "CNAME"
      records = ["C7971662B49F45088A64082CAD9A2C2D.189F84997D9058E2B7F83113ABA9FE3F.5daf3c42d7926.comodoca.com."]
    },

    ### Sendgrid
    "sendgrid_1" = {
      name    = "em3548.www.hakes.com"
      type    = "MX"
      records = ["10 mx.sendgrid.net."]
    },
    "sendgrid_2" = {
      name    = "em3548.www.hakes.com"
      type    = "TXT"
      records = ["v=spf1 include:sendgrid.net ~all"]
    },
    "sendgrid_3" = {
      name    = "m1._domainkey.www.hakes.com"
      type    = "TXT"
      records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDY2fzz6lQ4tFKuDC8zdUkH31NB6GQa+JeuUVdlqSvY3Vzveu0YEs951CkSSBzzA4MEsKYAeO9C5C93CDlzJD4se5OkBnwlUAYQ3D4kI+V6+6WzKFuZi+6lH2upEt0e/5+n3yAVF77yCKE/kghm+EkESVJFp7ef0E3xwrAIV1uB1wIDAQAB"]
    },
    "sendgrid_4" = {
      name    = "_dmarc.www.hakes.com"
      type    = "TXT"
      records = ["v=DMARC1; p=none; pct=100; rua=mailto:dmarc@fbl.optin.com"]
    },
    "sendgrid_5" = {
      name    = "url6390.www.hakes.com"
      type    = "CNAME"
      records = ["sendgrid.net"]
    },
    "sendgrid_6" = {
      name    = "53038784.www.hakes.com"
      type    = "CNAME"
      records = ["sendgrid.net"]
    },
    ###

    ### aWeber email CNAME
    "aweber_cname_1" = {
      name    = "aweber_key_a._domainkey"
      type    = "CNAME"
      records = ["aweber_key_a.send.aweber.com."]
    },
    "aweber_cname_2" = {
      name    = "aweber_key_b._domainkey"
      type    = "CNAME"
      records = ["aweber_key_b.send.aweber.com."]
    },
    "aweber_cname_3" = {
      name    = "aweber_key_c._domainkey"
      type    = "CNAME"
      records = ["aweber_key_c.send.aweber.com."]
    },
    ###

    ### Lync Online and CNAME and Skype
    "lync_cname_1" = {
      name    = "sip"
      type    = "CNAME"
      records = ["sipdir.online.lync.com."]
    },
    "lync_cname_2" = {
      name    = "lyncdiscover"
      type    = "CNAME"
      records = ["webdir.online.lync.com."]
    },
    "lync_cname_3" = {
      name    = "autodiscover"
      type    = "CNAME"
      records = ["autodiscover.outlook.com."]
    },
    "lync_cname_4" = {
      name    = "msoid"
      type    = "CNAME"
      records = ["clientconfig.microsoftonline-p.net."]
    },
    "lync_cname_5" = {
      name    = "enterpriseregistration"
      type    = "CNAME"
      records = ["enterpriseregistration.windows.net."]
    },
    "lync_cname_6" = {
      name    = "enterpriseenrollment"
      type    = "CNAME"
      records = ["enterpriseenrollment.manage.microsoft.com."]
    },
    ###

    ### Lync Online and CNAME and Skype
    "lync_srv_1" = {
      name    = "_sip._tls"
      type    = "SRV"
      records = ["100 1 443 sipdir.online.lync.com"]
    },
    "lync_srv_2" = {
      name    = "_sipfederationtls._tcp"
      type    = "SRV"
      records = ["100 1 5061 sipfed.online.lync.com."]
    },
    ###

  }
}

resource "aws_route53_zone" "hakes_com" {
  name = "hakes.com"
}

resource "aws_route53_record" "this" {
  for_each = local.dns_records

  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = lookup(each.value, "ttl", 300) # Default to 300
  records = each.value.records
}
