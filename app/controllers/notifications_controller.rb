class NotificationsController < ApplicationController
    def mark_all_readed
        @notifications.update_all(readed: true)
    end
end
