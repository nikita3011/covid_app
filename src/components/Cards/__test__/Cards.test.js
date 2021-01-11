import React from "react";
import { shallow } from "enzyme";
import { findByTestAtrr } from "../../../../utils/index";
// import Enzyme from "enzyme";
// import Adapter from "enzyme-adapter-react-16";
import Cards from "../Cards";


// Enzyme.configure({
//     adapter: new Adapter(),
//   });


describe("Cards", () => {
  describe("cards test", () => {
    let wrapper;
    beforeEach(() => {
      const props = {
          data:{
              confirmed:1,
              recovered:2,
              deaths:3,
              lastUpdate:4
          }
      };
      wrapper = shallow(<Cards{...props} />);
    });

    it("should render card", () => {
      const cardComponent = findByTestAtrr(wrapper, "card");
      expect(cardComponent.length).toBe(3);
    });
  });
});