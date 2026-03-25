
class C3PO

  def initialize
    $crypt_key = "Sh4r3d_K3y_F0r_t3st1ing_0nly_32B"
    $mode_map = { "ascom" => 1, "engage" => 1, "pk" => 2 }
  end

  def get_partner_uri(platform, partner, target, site_id, site_url=nil, unit=nil, bed=nil, time=nil, mrn=nil)
    # site_url = "http://site34.dev-host-03.utangtech.com/develop"
    $site_base_url = "#{site_url}/#/api/sharelink/"
    $mobile_base_url = "utangone://"
    $partner = partner
    $target = target
  end

  def get_uri_mode(partner)

  end

  def get_uri
    nil
  end

  def get_facility_id(site_id)
    facility_ids = {
      1763 => "QA34",
      1770 => "QA39",
      4103 => "55",
      4104 => "MNX1",
      4121 => "MRPM",
      4148 => "ASite",
      4168 => "Dev7",
      4170 => "Dev8",
      4186 => "QA35",
      4396 => "33QA",
      4543 => "WAVE",
      4577 => "BSI",
      4604 => "DEVD",
      4645 => "NK",
      4707 => "SiVir"
    }
    return facility_ids[site_id.to_i]
  end

end



c3po = C3PO.new
c3po.get_partner_uri(
  platform='mobile',
  partner='ascom',
  site_id='1763',
  site_url='http://site34.dev-host-03.utangtech.com/develop'
)
print c3po.get_facility_id(1763)

