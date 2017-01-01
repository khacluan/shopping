module AdministrativeUnits
  class Vietnam < Base
    def initialize
      super
    end

    def base_uri
      'https://thongtindoanhnghiep.co/api/'
    end

    def import
      country = create_country
      import_cities(country)
    end

    private

    def create_country
      country_unit = Unit.find_or_initialize_by(unit_type: Unit.unit_types[:country], code: 'VN')
      country_unit.attributes = {name: 'Vietnam', stand_for: 'vn', slug: 'viet-nam', area_number: '084'}
      country_unit.save!
      country_unit
    end

    def import_cities(country)
      results = request('city')
      if results
        cities = results['LtsItem']
        cities.each do |city|
          next if country.children.exists?(code: city['ID'])

          city_unit = country.children.create(
            unit_type: Unit.unit_types[:city],
            slug: city['SolrID'],
            name: city['Title'],
            stand_for: stand_for(city['Title']),
            code: city['ID']
          )

          import_districts(city_unit)
        end
      end
    end

    def import_districts(city)
      districts = request("city/#{city.code}/district")
      districts.each do |district|
        next if city.children.exists?(code: district['ID'])

        d_unit = city.children.create(
          unit_type: Unit.unit_types[:district],
          code: district['ID'],
          name: district['Title'],
          stand_for: stand_for(district['Title']),
          slug: district['SolrID'].split('/').last
        )

        import_wards(d_unit)
      end
    end

    def import_wards(district)
      wards = request("district/#{district.code}/ward")
      wards.each do |ward|
        next if district.children.exists?(code: ward['ID'])

        district.children.create(
          unit_type: Unit.unit_types[:ward],
          code: ward['ID'],
          name: ward['Title'],
          stand_for: stand_for(ward['Title']),
          slug: ward['SolrID'].split('/').last
        )
      end
    end
  end
end

