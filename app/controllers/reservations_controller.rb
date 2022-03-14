class ReservationsController < ApplicationController
  def index
    converted_params = convert_params
    guest = process_guest(converted_params)
    result =  process_reservation(guest, converted_params)

    render json: result
  end

  private
    def check_version
      params[:reservation_code] ? 1 : 2
    end

    def convert_params
      converted_params = params

      version = check_version

      if version == 2
        reservation = params[:reservation]
        detail = reservation[:guest_details]

        converted_params = ActionController::Parameters.new({
          reservation_code: reservation[:code],
          start_date: reservation[:start_date],
          end_date: reservation[:end_date],
          nights: reservation[:nights],
          guests: reservation[:number_of_guests],
          adults: detail[:number_of_adults],
          children: detail[:number_of_children],
          infants: detail[:number_of_infants],
          status: reservation[:status_type],
          currency: reservation[:host_currency],
          payout_price: reservation[:expected_payout_amount],
          security_price: reservation[:listing_security_price_accurate],
          total_price: reservation[:total_paid_amount_accurate],
          guest: {
            first_name: reservation[:guest_first_name],
            last_name: reservation[:guest_last_name],
            phone: reservation[:guest_phone_numbers].join(","),
            email: reservation[:guest_email]
          }
        })
      end

      converted_params
    end

    def reservation_params(converted_params)
      converted_params.permit(:reservation_code, :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :status, :currency, :payout_price, :security_price, :total_price)
    end

    def guest_params(converted_params)
      converted_params.require(:guest).permit(:first_name, :last_name, :email, :phone)
    end

    def process_guest(converted_params)
      data = guest_params(converted_params)

      guest = Guest.find_by(email: data[:email])

      if !guest
        guest = Guest.create(data)
      else
        guest.update(data)
      end

      guest
    end

    def process_reservation(guest, converted_params)
      data = reservation_params(converted_params)

      reservation = Reservation.find_by(reservation_code: data[:reservation_code])

      if !reservation
        reservation = guest.reservations.create(data)
      else
        reservation.update(data)
      end

      result = reservation.serializable_hash
      result["guest"] = guest.serializable_hash

      result
    end
end
