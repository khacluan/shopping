module Api
  module V1
    class UnitsController < ActionController::API
      def districts_by_city
        city = Unit.find_by_id(params[:city_id])
        return render(json: {}) unless city

        render json: city.children
      end

      def wards_by_district
        district = Unit.find_by_id(params[:district_id])
        return render(json: {}) unless district

        render json: district.children
      end
    end
  end
end
