class Unit < ApplicationRecord
  enum unit_type: {
    country:  'Country',
    city: 'City',
    district: 'District',
    ward:     'Ward'
  }

  has_ancestry

end

