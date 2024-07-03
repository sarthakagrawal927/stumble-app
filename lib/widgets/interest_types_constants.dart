enum InterestType { hookup, relationship, friendship }

const interestValue = {
  InterestType.hookup: 1,
  InterestType.relationship: 2,
  InterestType.friendship: 3,
};

var interestToLabel = {
  InterestType.friendship: "Just a Conversation",
  InterestType.hookup: "Casual Encounter",
  InterestType.relationship: "Relationship",
};

var labelToInterest = {
  interestToLabel[InterestType.friendship]: InterestType.friendship,
  interestToLabel[InterestType.hookup]: InterestType.hookup,
  interestToLabel[InterestType.relationship]: InterestType.relationship,
};
