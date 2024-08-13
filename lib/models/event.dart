class Event {
  final int eventId;
  final String eventName;
  final String eventDescription;
  final String eventLink;
  final String eventImageUrl;
  final String eventStartTime;
  final String eventEndTime;
  final String eventLocationName;
  final String eventOrganizerName;
  final String eventOrganizerImage;
  final String? eventLocationId;
  final int? eventType;
  final int? eventStatus;
  final int? eventOrganiserId;
  final int? numberOfInterestedUsersInEvent;
  final String? eventCreatedAtTimeStamp;

  Event(
      {required this.eventId,
      required this.eventName,
      required this.eventDescription,
      required this.eventLink,
      required this.eventImageUrl,
      required this.eventStartTime,
      required this.eventEndTime,
      required this.eventLocationName,
      required this.eventOrganizerName,
      required this.eventOrganizerImage,
      this.eventLocationId,
      this.eventType,
      this.eventStatus,
      this.eventOrganiserId,
      this.numberOfInterestedUsersInEvent,
      this.eventCreatedAtTimeStamp,
      });

  static fromJson(dynamic event) {
    return Event(
      eventId: event["id"],
      eventName: event["name"],
      eventDescription: event["description"],
      eventLink: event["link"],
      eventImageUrl: event["image_url"],
      eventStartTime: event["start_time"],
      eventEndTime: event["end_time"],
      eventLocationName: event["location_name"],
      eventOrganizerName: event["organizer_name"],
      eventOrganizerImage: event["organizer_image"]

      // TODO: Add as per need in future.
      
      // eventLocationId: event["location_id"],
      // eventType: event["event_type"],
      // eventStatus: event["status"],
      // eventOrganiserId: event["organizer_id"],
      // numberOfInterestedUsersInEvent: event["num_interested_users"],
      // eventCreatedAtTimeStamp: event["createdAt"],
    );
  }
}
